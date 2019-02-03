library feddit.src.routes;

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:angel_static/angel_static.dart';
import 'package:file/file.dart';
import 'package:http_parser/http_parser.dart';
import 'controllers/controllers.dart' as controllers;

var activityJson = MediaType('application', 'activity+json');
var ldJson = MediaType('application', 'ld+json');

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    bool acceptsActivityPub(RequestContext req) {
      return req.accepts(activityJson, strict: true) ||
          req.accepts(ldJson, strict: true);
    }

    // Typically, you want to mount controllers first, after any global middleware.
    await app.configure(controllers.configureServer);

    // Render `views/hello.jl` when a user visits the application root.
    app.get('/', (req, res) => res.render('hello'));

    app.get('/u/:username', (req, res) {
      var username = req.params['username'];

      if (acceptsActivityPub(req)) {
        res.serialize(
          {
            "@context": "https://www.w3.org/ns/activitystreams",
            "type": "Person",
            "name": username
          },
          contentType: MediaType('application', 'jrd+json'),
        );
      } else {
        return 'TODO: Page for $username';
      }
    });

    // Mount static server at web in development.
    // The `CachingVirtualDirectory` variant of `VirtualDirectory` also sends `Cache-Control` headers.
    //
    // In production, however, prefer serving static files through NGINX or a
    // similar reverse proxy.
    //
    // Read the following two sources for documentation:
    // * https://medium.com/the-angel-framework/serving-static-files-with-the-angel-framework-2ddc7a2b84ae
    // * https://github.com/angel-dart/static
    if (!app.isProduction) {
      var vDir = VirtualDirectory(
        app,
        fileSystem,
        source: fileSystem.directory('web'),
      );
      app.fallback(vDir.handleRequest);
    }

    // Throw a 404 if no route matched the request.
    app.fallback((req, res) => throw AngelHttpException.notFound());

    // Set our application up to handle different errors.
    //
    // Read the following for documentation:
    // * https://github.com/angel-dart/angel/wiki/Error-Handling

    var oldErrorHandler = app.errorHandler;
    app.errorHandler = (e, req, res) async {
      if (!req.accepts('text/html', strict: true))
        return await oldErrorHandler(e, req, res);
      else {
        if (e.statusCode == 404) {
          return await res
              .render('error', {'message': 'No file exists at ${req.uri}.'});
        }

        return await res.render('error', {'message': e.message});
      }
    };
  };
}
