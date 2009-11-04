From: Cliff Brake <cliff.brake-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PXA270 SPI + SD card
Date: Wed, 4 Nov 2009 16:54:18 -0500
Message-ID: <f96d234e0911041354p1f11e415g427ec9b74ff4d25b@mail.gmail.com>
References: <f96d234e0911041353o25aeee4aqbb482f162aaeac5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f96d234e0911041353o25aeee4aqbb482f162aaeac5f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 4, 2009 at 4:53 PM, Cliff Brake <cliff.brake-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hello,
>
> I'm trying to get a PXA270 to talk to a SD card via SPI. =A0Has anyone
> else done this?
>
> One of the requirements is the CS stay low for the entire transaction.
> =A0Can this be done with the PXA270 controlling the frame (CS) signal,
> or is GPIO control typically required?

Also, what SPI mode is typically used for SD?  Looks like 0 and 3 are
the closest (http://elm-chan.org/docs/spi_e.html).

Thanks,
Cliff

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
