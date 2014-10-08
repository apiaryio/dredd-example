db = require("mongous").Mongous

console.log "Resetting database..."

db('test.$cmd').find({'drop': 'machines'},1)
db('test.$cmd').find({"create": "machines"},1)


process.exit 0