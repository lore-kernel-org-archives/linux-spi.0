From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 09/14] Blackfin SPI driver: Fix SPI
	driver to work with SPI flash ST25P16 on bf548
Date: Wed, 31 Oct 2007 00:11:33 -0700
Message-ID: <200710310011.33545.david-b@pacbell.net>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
	<200710301305.02640.david-b@pacbell.net>
	<1193813431.6971.24.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193813431.6971.24.camel@roc-laptop>
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

On Tuesday 30 October 2007, Bryan Wu wrote:
> Maybe there are some confusion of mixing up the spi_trasnfer.speed_hz
> with the spi_device.max_speed_hz.
> 
> spi_device.max_speed_hz comes from spi_board_info.max_speed_hz, it is
> for the default max speed value.

It's initialized from board_info, yes.  Drivers can override it
using spi_setup().

One would expect they only override _downwards_ but that's not
guaranteed anywhere.  A driver might have a way to establish that
this particular board can run faster, for example.


> spi_transfer.speed_hz comes from upper applications for each spi
> transfer setting.

Certainly; all spi_transfer records come from applications!
If that value is zero, that transfer segment uses the limit
from the spi_device ... otherwise, it can differ.  Again,
the limits can vary based on devise characteristics; maybe
it can't feed data as fast for some commands.

(ISTR the M25P16 in $SUBJECT has two read commands, one of
which is only usable at clock rates below 33 MHz or so, but
most other commands can work above that speed just fine.)

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
