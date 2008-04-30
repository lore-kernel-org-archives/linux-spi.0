From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] Initial support for ST
	Microelectronics lis3l02dq accelerometer via SPI
Date: Tue, 29 Apr 2008 18:32:27 -0700
Message-ID: <200804291832.27827.david-b@pacbell.net>
References: <481210CC.9080702@cam.ac.uk> <481226C4.9010806@cam.ac.uk>
	<4815D9A6.4040306@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4815D9A6.4040306-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
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

On Monday 28 April 2008, Jonathan Cameron wrote:
> =

> from Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> =

> Initial support for ST Microelectronics LISS3L02DQ accelerometer via SPI

Extra "S" there I think.  :)


> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> =

> ---
> =

> This is a corrected version of the patch I posted the other day. =A0
> All comments / feedback welcomed. Would it be preferable to submit this
> as two patches, the first containing the basic functionality for directly
> accessing the device and second patching against that to add ring buffer /
> interrupt support?

One patch is fine, I think.


> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 14
> =A0drivers/spi/LIS3L02DQ.c =A0 =A0 =A0 | =A0774 +++++++++++++++++++++++++=
+++++++
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01
> =A0include/linux/spi/LIS3L02DQ.h | =A0168 ++++++
> =A04 files changed, 957 insertions(+)

First technical feedback:  names in *lower case* please!  Hold
off on a new patch until I look at the code a bit.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
