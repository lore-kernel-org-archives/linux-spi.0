From: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: ADS1256 - too fast for Linux ?
Date: Fri, 14 Jan 2011 16:29:42 -0700
Message-ID: <4D30DC66.6080706@codeaurora.org>
References: <AANLkTikhEd1AER28AoV3DVqZENzXyX3RRpv7CP2sOvdE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: =?ISO-8859-1?Q?Fl=E1vio_Alberto_Lopes_Soares?= <flavioalsoares-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTikhEd1AER28AoV3DVqZENzXyX3RRpv7CP2sOvdE-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 01/14/2011 05:02 AM, Fl=E1vio Alberto Lopes Soares wrote:
> Hello all,
> I need to communicate with a Texas Instruments ADS1256 SPI 24 bits ADC (
> http://focus.ti.com/docs/prod/folders/print/ads1256.html) from a 2.6.32
> kernel Linux running on a ARM Samsung S3C2440 microcontroller using spidev
> module, to do this I need to pass a command on MOSI channel and after read
> the result on MISO, but I can't read the correct data from this ADC, the
> data is always corrupted, I believe (but I can't prove this) this occurs
> because the very short time between the command and response, according w=
ith
> the component datasheet this time is 50x the clock period, for my circuit
> this is approximately 8us and I believe that there's no time to Linux get
> the interrupt from SPI process this and read the SPI data, my suspicion c=
an
> be correct ? The DMA cannot solve this problem and if true how to know if=
 it
> is activated ? Only Real Time Linux can solve this ?
>
> Thanks for all help
>
> Flavio Alberto Lopes Soares
> -------------------------------------------------------------------------=
-----
> Protect Your Site and Customers from Malware Attacks
> Learn about various malware tactics and how to avoid them. Understand
> malware threats, the impact they can have on your business, and how you
> can protect your company and customers by using code signing.
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>

Curious if the SPI mode (clock polarity and phase) are set correctly for =

the device that you are communicating with.

Ken

-- =

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
