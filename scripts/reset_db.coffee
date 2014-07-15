db = require("mongous").Mongous

console.log "Resetting database..."

db('test.$cmd').find({'drop': 'gists'},1)
db('test.$cmd').find({"create": "gists"},1)

db('test.$cmd').find({'drop': 'stars'},1)
db('test.$cmd').find({"create": "stars"},1)

process.exit 0