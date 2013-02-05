From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/6] spi/ath79: add delay between SCK changes
Date: Tue, 05 Feb 2013 20:52:06 +0100
Message-ID: <511162E6.4050607@openwrt.org>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
	<1356601349-23617-2-git-send-email-juhosg@openwrt.org>
	<20130205125719.878EE3E0E27@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205125719.878EE3E0E27@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

> On Thu, 27 Dec 2012 10:42:24 +0100, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
>> The driver uses the "as fast as it can" approach
>> to drive the SCK signal. However this does not
>> work with certain low speed SPI chips (e.g. the
>> PCF2123 RTC chip).
>>
>> The patch adds per-bit slowdowns in order to be
>> able to use the driver with such chips as well.
>>
>> Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> 
> I've applied this, but please take a second look to make sure you're not
> doing something unintended. The ndelay call will spin until it
> completes. If the current context is interrupted or scheduled out then
> it will still spin when it gets back. You may be wasting more time than
> is necessary. It would be better to check the wall time over a loop
> iteration. And if the delay required is large, then it should sleep.

Thank for the review!

Unfortunately, at the moment I don't have access to the board which uses that
PCF2123 chip but I will try to improve the code.

-Gabor


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
