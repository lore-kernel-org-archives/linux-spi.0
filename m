From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] intel_mid_ssp_spi: Moorestown and Medfield SPI for SSP
	devices
Date: Thu, 26 Jan 2012 20:22:50 +0000
Message-ID: <20120126202250.02d8a4ac@pyramind.ukuu.org.uk>
References: <20120126175730.13631.67348.stgit@bob.linux.org.uk>
	<CACxGe6uHm54gKkBdCDxhJdwxGnCKPW0wWPwbXA+vT_qijfMFAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACxGe6uHm54gKkBdCDxhJdwxGnCKPW0wWPwbXA+vT_qijfMFAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 26 Jan 2012 12:18:41 -0700
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Thu, Jan 26, 2012 at 10:57 AM, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wro=
te:
> > From: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > This driver is a fusion of various internal drivers into a single
> > driver for the SPI slave/master on the Intel Moorestown and Medfield
> > SSP devices.
> >
> > Signed-off-by: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > [Queueing and runtime pm added]
> > Signed-off-by: Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > [Ported to the -next tree DMA engine, stripped Moorestown, further clea=
nup]
> > Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >
> > =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08
> > =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02
> > =A0drivers/spi/spi-intel-mid-ssp.c | 1426 +++++++++++++++++++++++++++++=
++++++++++
> > =A0drivers/spi/spi-intel-mid-ssp.h | =A0308 ++++++++
> =

> Haven't reviewed the patch yet, but I've got a question on this.  Are
> there any other users of this header file?  Can I just roll it into
> the .c file if I pick up the patch?

They can be rolled together. There is a driver pending for the device in
I=B2S mode but there isn't anything in common.

Alan

---------------------------------------------------------------------------=
---
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
