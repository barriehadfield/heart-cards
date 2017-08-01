class AppRouter < Hyperloop::Router
  history :browser

  route do
    DIV {
      Switch do
        Route('/', exact: true, mounts: Home)
        Route('/exercises', exact: true, mounts: Exercises)
        Route('/muscle-groups', exact: true, mounts: MuscleGroups)
        Route('/rule-sets', exact: true, mounts: RuleSets)
        Route('/members', exact: true, mounts: Members)
        # Route('/team/:id') { |m, l, h| Teams::Show(match: m, location: l, history: h) }
      end
    }
  end
end
