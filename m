From: "LTI. - Ticmanis, Linards" <LTI-mKfYHFOTJHu+onKQ3Rj6Dg@public.gmane.org>
Subject: wpa_supplicant: "LEAP (note: requires special
	support from the driver)"
Date: Thu, 13 Dec 2007 01:11:30 +0100
Message-ID: <37ED64EE21A398409D609EAF7B0525A021651E@hw-mail.hannover.huwag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

Hello to all of you,

is there someone in here who could help me with this note found on the wpa_supplicant website?

    "* LEAP (note: requires special support from the driver)"

What exactly does my driver have to do extra to support LEAP? Is it another ioctl or some such?

The driver I'm working on is basically an older version of the marvell-libertas code found in the most recent Linux kernel (currently, changing my project to that kernel is not yet possible for other resons). LEAP-based WPA works fine, but I can't find a way to get "LEAP with dynamic WEP keys" working.

I'd be extremely grateful for any help or hints.

Regards,
-- 
Linards Ticmanis

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
