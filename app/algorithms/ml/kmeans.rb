# k-means: puntos coloreados por asignación, centroides que se mueven al
# promedio hasta converger. Emite pasos { centroids, assign, it }.
module ML
  class KMeans
    attr_reader :points

    def initialize(points, k: 3)
      @points = points
      @k = k
    end

    def trace
      t = Trace.new
      centroids = @points.sample(@k)
      t.emit(:seed, centroids: centroids, assign: nil, it: 0)

      assign = Array.new(@points.size, -1)
      1.upto(12) do |it|
        assign = @points.map { |p| nearest(p, centroids) }
        t.emit(:assign, centroids: centroids, assign: assign, it: it)

        moved = false
        centroids = centroids.each_index.map do |ci|
          members = @points.select.with_index { |_, i| assign[i] == ci }
          next centroids[ci] if members.empty?
          nc = mean(members)
          moved ||= dist2(nc, centroids[ci]) > 1e-6
          nc
        end
        t.emit(:move, centroids: centroids, assign: assign, it: it)
        break unless moved
      end

      t.emit(:done, centroids: centroids, assign: assign, it: "✓")
      t.to_a
    end

    private

    def nearest(p, cs) = cs.each_index.min_by { |i| dist2(p, cs[i]) }
    def dist2(a, b) = (a[0] - b[0])**2 + (a[1] - b[1])**2
    def mean(ms) = [ ms.sum { _1[0] } / ms.size.to_f, ms.sum { _1[1] } / ms.size.to_f ]
  end
end
