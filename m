From: llandre <r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Subject: Re: Protocol driver probe function never invoked
Date: Thu, 26 Jul 2007 09:30:21 +0200
Message-ID: <46A84D8D.7050603@dave-tech.it>
References: <46A46CCA.7010303@dave-tech.it> <46A59E7A.8010204@dave-tech.it>
	<200707240628.14536.david-b@pacbell.net>
	<200707240632.53496.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707240632.53496.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> On Tuesday 24 July 2007, David Brownell wrote:
>> I want to be sure I understand this correctly.  You're saying that
>> the call to spi_setup() inside of spi_new_device() failed silently?
No, I did not make myself clear.
I was talking about this code in spi_imx.c:

	/* SPI datarate */
	tmp = spi_data_rate(spi->max_speed_hz);
	if (tmp == SPI_CONTROL_DATARATE_BAD) {
		status = -EINVAL;
		dev_err(&spi->dev,
			"setup - "
			"HW min speed (%d Hz) exceeds required "
			"max speed (%d Hz)\n",
			spi_speed_hz(SPI_CONTROL_DATARATE_MIN),
			spi->max_speed_hz);
		if (first_setup)
			goto err_first_setup;
		else
			/* Undo setup using chip as backup copy */


Since the reference clock feeding the SPI controller was too high, it 
was not able to generate the required SPI clock. Probably I did not pay 
enough attention, but it seems kernel did not print these error messages 
so it took a while to recognize that the this was the problem.



-- 
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
