class AppRouter < Hyperloop::Router
  history :browser

  route do
    DIV {
      Switch do
        Route('/', exact: true, mounts: Home)
        Route('/members', exact: true, mounts: Members)
      end
    }
  end
end
