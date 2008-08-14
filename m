From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc3] spi: bugfix
	spi_add_device() with duplicate chipselects
Date: Thu, 14 Aug 2008 14:34:27 -0700
Message-ID: <200808141434.27713.david-b@pacbell.net>
References: <200808140215.13641.david-b@pacbell.net>
	<20080814141438.319dfb52.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080814141438.319dfb52.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

On Thursday 14 August 2008, Andrew Morton wrote:
> @@ -219,8 +219,6 @@ struct spi_device *spi_alloc_device(stru
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_alloc_device);
> =A0
> -static DEFINE_MUTEX(spi_add_lock);
> -
> =A0/**
> =A0 * spi_add_device - Add spi_device allocated with spi_alloc_device
> =A0 * @spi: spi_device to register
> @@ -232,6 +230,7 @@ static DEFINE_MUTEX(spi_add_lock);
> =A0 */
> =A0int spi_add_device(struct spi_device *spi)
> =A0{
> +=A0=A0=A0=A0=A0=A0=A0static DEFINE_MUTEX(spi_add_lock);
> =A0=A0=A0=A0=A0=A0=A0=A0struct device *dev =3D spi->master->dev.parent;
> =A0=A0=A0=A0=A0=A0=A0=A0int status;
> =A0
> _
> =

> =

> OK?

Sure.  You're right, that is indeed neater.  Plus, if no Linux FAQ
currently says so, minimizing lock scope is a Very Good Thing.

- Dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
