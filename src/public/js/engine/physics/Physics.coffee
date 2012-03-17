b2Vec2 = Box2D.Common.Math.b2Vec2
b2AABB = Box2D.Collision.b2AABB
b2BodyDef = Box2D.Dynamics.b2BodyDef
b2Body = Box2D.Dynamics.b2Body
b2FixtureDef = Box2D.Dynamics.b2FixtureDef
b2Fixture = Box2D.Dynamics.b2Fixture
b2World = Box2D.Dynamics.b2World
b2MassData = Box2D.Collision.Shapes.b2MassData
b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
b2DebugDraw = Box2D.Dynamics.b2DebugDraw
b2MouseJointDef =  Box2D.Dynamics.Joints.b2MouseJointDef


class Physics
  constructor: ->
    log "Creating"
    @box2d = new b2World(new b2Vec2(0, 200), true)
    b2_maxTranslation = Box2D.Common.b2Settings.b2_maxTranslation = 30
    Box2D.Common.b2Settings.b2_maxTranslationSquared = b2_maxTranslation*b2_maxTranslation

  apply: (world) ->
    @box2d.Step(1 / 60, 10, 10)
    @box2d.ClearForces()

  createGround: (width, height) ->
    groundBodies = []

    fixDef = new b2FixtureDef
    fixDef.density = 1.0
    fixDef.friction = 0.5
    fixDef.restitution = 0.2

    bodyDef = new b2BodyDef
    log "Creating ground"
    bodyDef.type = b2Body.b2_staticBody
    fixDef.shape = new b2PolygonShape

    fixDef.shape.SetAsBox(width/2, 10)
    bodyDef.position.Set(width/2, height+10)
    groundBodies.push @box2d.CreateBody(bodyDef).CreateFixture(fixDef)

    fixDef.shape.SetAsBox(width/2, 10)
    bodyDef.position.Set(width/2, -10)
    groundBodies.push @box2d.CreateBody(bodyDef).CreateFixture(fixDef)

    fixDef.shape.SetAsBox(10, height/2)
    bodyDef.position.Set(width+10, height/2)
    groundBodies.push @box2d.CreateBody(bodyDef).CreateFixture(fixDef)

    fixDef.shape.SetAsBox(10, height/2)
    bodyDef.position.Set(-10, height/2)
    groundBodies.push @box2d.CreateBody(bodyDef).CreateFixture(fixDef)

    groundBodies

  createShipBody: (x, y) ->
    log "Spawning a ship"
    fixDef = new b2FixtureDef
    fixDef.density = 1.0
    fixDef.friction = 0.5
    fixDef.restitution = 0.2
    fixDef.shape = new b2CircleShape 14

    bodyDef = new b2BodyDef
    bodyDef.type = b2Body.b2_dynamicBody
    bodyDef.position.x = x
    bodyDef.position.y = y
    body = @box2d.CreateBody(bodyDef).CreateFixture(fixDef)

    #log body

define "luolis.game.physics.Physics", Physics
