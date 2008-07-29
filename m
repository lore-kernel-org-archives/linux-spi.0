From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.26+] spi:  new orion_spi driver
Date: Mon, 28 Jul 2008 23:43:24 -0700
Message-ID: <200807282343.25058.david-b@pacbell.net>
References: <200807221228.00958.david-b@pacbell.net>
	<20080728211655.4d51e921.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	saeed <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lennert Buijtenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080728211655.4d51e921.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

On Monday 28 July 2008, Andrew Morton wrote:
> > +
> > +=A0=A0=A0=A0=A0if (orion_spi_baudrate_set(spi, speed) !=3D 0)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> > +
> > +=A0=A0=A0=A0=A0if (orion_spi_set_transfer_size(orion_spi, bits_per_wor=
d) !=3D 0)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> =

> Given that orion_spi_baudrate_set() and orion_spi_set_transfer_size()
> carefully return an -EFOO value, it's a bit unkind to just rub that out
> and return a hard-coded -EINVAL.

Right; I suppose I was so glad to see the previous issue fixed that
I ended up overlookig that one!

Shadi ... can you provide updates for these issues?

- Dave


> > ...
> >
> > +static void __exit orion_spi_exit(void)
> > +{
> > +=A0=A0=A0=A0=A0platform_driver_unregister(&orion_spi_driver);
> > +
> > +=A0=A0=A0=A0=A0destroy_workqueue(orion_spi_wq);
> > +}
> =

> Please double-check the workqueue handling. =A0Without looking at it too
> closely, I think that this is waaaay too late to be running
> destroy_workqueue(). =A0If a work is still pending, all the data upon
> which it will be operating will have been rubbed out. =A0I'm suspecting
> that an earlier flush_work() (or similar) will be needed.
> =




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
