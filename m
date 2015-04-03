From: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: fsl-dspi: better approximation for baudrate
Date: Fri, 03 Apr 2015 10:50:46 -0700
Message-ID: <551ED2F6.8020701@datasoft.com>
References: <1427965907-28125-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427965907-28125-1-git-send-email-andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Andy,

See comments below.

On 04/02/2015 02:11 AM, Andy Shevchenko wrote:
> This series makes better approximation when baud rate divisor parameters are
> calculated.
>
> The algorithm is represent as Python script here [1]. First parameter is
> algorithm (0 - original, 1 - after patch 1/2, 2 - after patch 2/2, 3 - memory
> vs. performance: use precalculated scales).
>
> I played with let's say standard baud rates (which I used for Quark) and
> separately run algorithms 0 and 1 for range 100-5000 baud. Input frequency is
> 64MHz. It seems my algo shows better results in all cases. Here is a diff for
> 'standard' baud rates
> (speed_hz, DBR, i, BR, j, PBR, real baud rate, difference):
>
> --- result0     2015-04-02 00:38:48.845761004 +0300
> +++ result1     2015-04-02 00:38:48.913760154 +0300
> @@ -5,7 +5,7 @@
>   25000000 0 0  2     0 2 16000000 9000000
>   20000000 0 0  2     0 2 16000000 4000000
>   16667000 0 0  2     0 2 16000000 667000
> -13333000 0 0  2     0 2 16000000 2667000
> +13333000 0 0  2     1 3 10666666 2666334

This one is definitely a bug in the original due to dropping the 
remainder in the 4.8 scale factor needed.

>   12500000 0 0  2     1 3 10666666 1833334
>   10000000 0 0  2     1 3 10666666 666666
>   8000000  0 1  4     0 2 8000000 0
> @@ -17,36 +17,36 @@
>   3140500  0 1  4     2 5 3200000 59500
>   3125000  0 1  4     2 5 3200000 75000
>   3109500  0 1  4     2 5 3200000 90500
> -2500000  0 1  4     3 7 2285714 214286
> +2500000  0 3  8     1 3 2666666 166666

The rest of these I'm not sure about.  The property is called 
"spi-max-frequency" and the description in the bindings document is:

- spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz

In the rest of the examples you've gotten a closer baud rate by 
exceeding the "Maximum" value.  I don't think you want best 
approximation, I think you want closest without going over..

>   2000000  0 4  16    0 2 2000000 0
>   1563000  0 3  8     2 5 1600000 37000
> -1250000  0 3  8     3 7 1142857 107143
> +1250000  0 4  16    1 3 1333333 83333
>   1006000  0 5  32    0 2 1000000 6000
>   1000000  0 5  32    0 2 1000000 0
>   994000   0 5  32    0 2 1000000 6000
>   800000   0 4  16    2 5 800000 0
> -781250   0 5  32    1 3 666666 114584
> -625000   0 4  16    3 7 571428 53572
> +781250   0 4  16    2 5 800000 18750
> +625000   0 5  32    1 3 666666 41666
>   500000   0 6  64    0 2 500000 0
>   400000   0 5  32    2 5 400000 0
> -390625   0 6  64    1 3 333333 57292
> +390625   0 5  32    2 5 400000 9375
>   250000   0 7  128   0 2 250000 0
>   200000   0 6  64    2 5 200000 0
>   205313   0 6  64    2 5 200000 5313
> -195313   0 7  128   1 3 166666 28647
> -185313   0 7  128   1 3 166666 18647
> +195313   0 6  64    2 5 200000 4687
> +185313   0 6  64    2 5 200000 14687
>   125000   0 8  256   0 2 125000 0
>   100700   0 7  128   2 5 100000 700
>   100000   0 7  128   2 5 100000 0
> -99300    0 8  256   1 3 83333 15967
> +99300    0 7  128   2 5 100000 700
>   50000    0 8  256   2 5 50000 0
>   25000    0 9  512   2 5 25000 0
> -10066    0 10 1024  3 7 8928 1138
> -10016    0 10 1024  3 7 8928 1088
> -9966     0 10 1024  3 7 8928 1038
> -5065     0 11 2048  3 7 4464 601
> -5040     0 11 2048  3 7 4464 576
> -5015     0 11 2048  3 7 4464 551
> +10066    0 11 2048  1 3 10416 350
> +10016    0 11 2048  1 3 10416 400
> +9966     0 11 2048  1 3 10416 450
> +5065     0 12 4096  1 3 5208 143
> +5040     0 12 4096  1 3 5208 168
> +5015     0 12 4096  1 3 5208 193
>   1007     0 15 32768 0 2 976 31
>   1002     0 15 32768 0 2 976 26
>   997      0 15 32768 0 2 976 21
>
> Patch 2 is RFC, since I don't know if all DSPI modules has that bit (at least
> what I found on public for MC55xx) and how duty cycle is significant.
>
> Not compiled. Not tested.
>
> [1] http://pastebin.com/uy0CKc6b
>
> Andy Shevchenko (2):
>    spi: fsl-dspi: increase precision of baud rate approximation
>    spi: fsl-dspi: use double baud rate in approximation
>
>   drivers/spi/spi-fsl-dspi.c | 50 +++++++++++++++++++++-------------------------
>   1 file changed, 23 insertions(+), 27 deletions(-)
>

Thanks,
Aaron

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
