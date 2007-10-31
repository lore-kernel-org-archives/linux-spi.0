From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 09/14] Blackfin SPI driver: Fix SPI
	driver to work with SPI flash ST25P16 on bf548
Date: Wed, 31 Oct 2007 01:02:36 -0700
Message-ID: <200710310102.36542.david-b@pacbell.net>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
	<200710310011.33545.david-b@pacbell.net>
	<1193816110.6971.50.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193816110.6971.50.camel@roc-laptop>
Content-Disposition: inline
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

On Wednesday 31 October 2007, Bryan Wu wrote:
> IMO, the spi_transfer.speed_hz <=3D spi_board_info.max_speed_hz and if
> spi_trasnfer.speed_hz is 0, we should use spi_board_info.max_speed_hz.
> From the meaning of max_speed_hz, the spi_transfer.speed_hz should not
> beyond max_speed_hz.

According to the interface spec that's not how it works; so I'm
not sure what you base your opinion on.  It's not defined with
such constraints.

That might be a reasonable policy to adopt in many cases, and
nothing prevents any given protocol driver from choosing to follow
it.  But likewise, if the driver chooses _not_ to follow it, it's
wrong for a controller driver to add its own private rules.


> In your explanation, the max_speed_hz is just a default value. the
> transfer speed_hz can beyond max_speed_hz.

Kerneldoc for board info says;

 * @max_speed_hz: Initializes spi_device.max_speed_hz; based on limits
 *      from the chip datasheet and board-specific signal quality issues.

So yes -- initial value, it can be changed.  If a driver says

	spi->max_speed_hz =3D X;
	spi_setup(spi);

that's how it requests a different clock rate ceiling.  It can lower
the rate; it can raise it.


The reason it's called max_speed_hz is that most systems compute the
clock rate by dividing a base clock, and few can achieve that exact
value.  The name indicates that it's to be treated as an upper limit,
not a lower limit or exact value.  The controller driver should get
as close to that rate as it can, without going over.


> We found the bug in M25P16 =

> should be related this missing checking of the transfer =A0speed_hz.

The m25p80 driver doesn't change that value...

So if there was any issue there, it must have been related to
something else in your controller driver.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
