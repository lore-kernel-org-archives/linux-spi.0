From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: RE: [PATCH 3/8] spi: spi-ep93xx: always handle transfer specific
	settings
Date: Fri, 28 Jun 2013 18:42:59 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC38FE45@AUSP01VMBX24.collaborationhost.net>
References: <201306281143.35130.hartleys@visionengravers.com>
	<51CE199A.4040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"mika.westerberg-X3B1VOXEql0@public.gmane.org" <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <51CE199A.4040606-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday, June 28, 2013 4:18 PM, Ryan Mallon wrote:
> On 29/06/13 04:43, H Hartley Sweeten wrote:
>> __spi_async(), which starts every SPI message transfer, initializes
>> the bits_per_word and max speed for every transfer in the message.
>> Since the conditional test in ep93xx_spi_process_transfer() will
>> always succeed just remove it and always call ep93xx_spi_chip_setup()
>> to configure the hardware for each transfer in the message.
>> 
>> Remove the redundant ep93xx_spi_chp_setup() in ep93xx_spi_process_transfer()
>> which just initializes the hardware to the "default" based on the SPI
>> device.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
>> Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
>> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>
>
>> +	err = ep93xx_spi_calc_divisors(espi, chip, t->speed_hz);
>> +	if (err) {
>> +		dev_err(&espi->pdev->dev, "failed to adjust speed\n");
>
>
> Printing out the speed it was trying to set might be useful here?

Technically I don't think this can ever happen.

The minimum and maximum possible speeds are determined during the probe.

	espi->max_rate = clk_get_rate(espi->clk) / 2;
	espi->min_rate = clk_get_rate(espi->clk) / (254 * 256);

Each transfer is validated to make sure the speed is greater than the
minimum.

		if (t->speed_hz < espi->min_rate)
			return -EINVAL;

Then the rate is clamped to the min/max rates.

	rate = clamp(rate, espi->min_rate, espi->max_rate);

The calculations for the div_csr and div_cpsr values needed to produce
the desired rate should always succeed.

Patch 7/8 actually replaces that dev_err() message with a more generic
one. In reality, even the new message, and the error checking, could
probably be removed.

Regards,
Hartley

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
