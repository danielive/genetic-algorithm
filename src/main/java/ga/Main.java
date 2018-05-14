package ga;

import org.knowm.xchart.*;
import org.knowm.xchart.style.colors.XChartSeriesColors;
import org.knowm.xchart.style.lines.SeriesLines;
import org.knowm.xchart.style.markers.SeriesMarkers;

import java.awt.*;
import java.io.IOException;

public class Main {

    private static double data1[] = new double[]{
            1150,
            630,
            40,
            750,
            750,
            1030,
            1650,
            1490,
            790,
            710,
            840,
            1170,
            970,
            510,
            750,
            1280,
            230,
            460,
            1040,
            590,
            830,
            490,
            1840,
            1260,
            1280,
            490,
            1460,
            1260,
            360
    };
    private static double data2[] = new double[]{
            1760,
            1660,
            2090,
            1100,
            2030,
            2070,
            650,
            1630,
            2260,
            1310,
            550,
            2300,
            1340,
            700,
            900,
            1200,
            590,
            860,
            950,
            1390,
            1770,
            500,
            1240,
            1500,
            790,
            2130,
            1420,
            1910,
            1980
    };

    public static void main(String[] args) throws IOException{
        //ga.MyFitnessFunction.generateRandomFile("matrix.txt", 256);
        MyFitnessFunction ff = new MyFitnessFunction("matrix.txt");
        GeneticEngine ge = new GeneticEngine(ff);
        ge.setIndividualCount(100); // Количество особей в поколении
        ge.setGenerationCount(10000); // Количество поколений
        ge.setSelectionType(GeneticEngine.SelectionType.TOURNEY); // Тип селекции
        ge.setCrossingType(GeneticEngine.CrossingType.ELEMENTWISE_RECOMBINATION); // Тип скрещивания
        ge.setUseMutation(true); // Наши геномы могут мутировать
        ge.setMutationPercent(0.02d); // Насколько часто мутируют геномы

        long time = System.currentTimeMillis();
        long[] better = ge.run(); // Запуск

        long timeToFF = ge.timeToFF;
        long timeToSelection = ge.timeToSelection;
        long timeToCrossing = ge.timeToCrossing;
        long timeToMutate = ge.timeToMutate;

        System.out.println("Running:\t"+(System.currentTimeMillis()-time)/1000 + " secs");
        System.out.println("FitnessFunc:\t"+timeToFF/1000 + " secs");
        System.out.println(" - FF Prepare:\t"+ff.prepareTime/1000 + " secs");
        System.out.println(" - FF QSort:\t"+ff.sortingTime/1000 + " secs");
        System.out.println(" - FF Check: \t"+ff.checkTime/1000 + " secs");
        System.out.println("Selection:\t"+(timeToSelection-timeToFF)/1000 + " secs");
        System.out.println("Crossing:\t"+timeToCrossing/1000 + " secs");
        System.out.println("Mutate: \t"+timeToMutate/1000 + " secs");
        System.out.println("Length of the route: " + (Long.MAX_VALUE-ff.run(better)));
        System.out.print("Sequence: ");

        double bestData1[] = new double[29];
        double bestData2[] = new double[29];

        for (int i = 0; i < ff.getSeq().length; i++) {
            System.out.print(ff.getSeq()[i] + " ");
            bestData1[i] = data1[ff.getSeq()[i]];
            bestData2[i] = data2[ff.getSeq()[i]];
        }

        XYChart chart = new XYChartBuilder().width(800).height(600).xAxisTitle("X").yAxisTitle("Y").build();
        XYSeries series = chart.addSeries("Best route", bestData1, bestData2);

        series.setLineColor(XChartSeriesColors.RED);
        series.setMarkerColor(Color.GREEN);
        series.setMarker(SeriesMarkers.CIRCLE);
        series.setLineStyle(SeriesLines.SOLID);

        new SwingWrapper(chart).displayChart();
    }

    private static void printLongInBin(long l, int last){
        if (last>0){
            int p = (int)(l & 1);
            printLongInBin(l>>1,--last);
            System.out.print(p);
        }
    }
}