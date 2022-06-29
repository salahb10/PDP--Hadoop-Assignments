from mrjob.job import MRJob
from mrjob.step import MRStep

class RatingsBreakdown (MRJob):
    def steps(self):
        return [
            MRStep(mapper=self.mapper_get_ratings,
                   reducer=self.reducer_count_ratings),
            MRStep(reducer=self.reducer_sort_counts)
        ]

    def mapper_get_ratings(self, _, line):
        (userID, movieID, rating, timestamp) = line.split('\t')
        yield movieID, 1

    def reducer_count_ratings (self, movieID, rating):
        yield None, (sum(rating), movieID)

    def reducer_sort_counts(self, _, values):
        for count_ratings, movieID in sorted(values, reverse=True):
            yield (count_ratings, int(movieID))


    

if __name__ == '__main__':
    RatingsBreakdown.run()


