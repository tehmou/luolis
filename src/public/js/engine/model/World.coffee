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

class World
  constructor: (width, height) ->
    log "Creating"

    @box2d = new b2World(new b2Vec2(0, 10), true)

    fixDef = new b2FixtureDef
    fixDef.density = 1.0
    fixDef.friction = 0.5
    fixDef.restitution = 0.2

    bodyDef = new b2BodyDef

#    log "Creating ground"
#    bodyDef.type = b2Body.b2_staticBody
#    fixDef.shape = new b2PolygonShape
#    fixDef.shape.SetAsBox(20, 2)
#    bodyDef.position.Set(10, 400 / 30 + 1.8)
#    @box2d.CreateBody(bodyDef).CreateFixture(fixDef)
#    bodyDef.position.Set(10, -1.8)
#    @box2d.CreateBody(bodyDef).CreateFixture(fixDef)
#    fixDef.shape.SetAsBox(2, 14)
#    bodyDef.position.Set(-1.8, 13)
#    @box2d.CreateBody(bodyDef).CreateFixture(fixDef)
#    bodyDef.position.Set(21.8, 13)
#    @box2d.CreateBody(bodyDef).CreateFixture(fixDef)

    @width = width
    @height = height
    @reset()

  reset: ->
    @ships = []

  createShip: ->
    fixDef = new b2FixtureDef
    fixDef.density = 1.0
    fixDef.friction = 0.5
    fixDef.restitution = 0.2
    fixDef.shape = new b2CircleShape 1

    bodyDef = new b2BodyDef
    bodyDef.type = b2Body.b2_dynamicBody
    bodyDef.position.x = Math.random() * @width
    bodyDef.position.y = Math.random() * @height
    @box2d.CreateBody(bodyDef).CreateFixture(fixDef)

  update: ->
    @box2d.Step(1 / 60, 10, 10)
    @box2d.ClearForces()

  getShipForPlayer: (clientId) ->
    (ship for ship in @ships when ship.clientId == clientId)[0]

define "luolis.game.model.World", World
