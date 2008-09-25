From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: removal of spidev oops on pxa270
Date: Wed, 24 Sep 2008 22:04:20 -0700
Message-ID: <200809242204.21175.david-b@pacbell.net>
References: <f96d234e0809200806p7adecdd3hfb29b4e99dc9c83a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f96d234e0809200806p7adecdd3hfb29b4e99dc9c83a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Saturday 20 September 2008, Cliff Brake wrote:
> static int spidev_remove(struct spi_device *spi)
> {
> =A0=A0=A0=A0=A0=A0=A0=A0struct spidev_data=A0=A0=A0=A0=A0=A0*spidev =3D s=
pi_get_drvdata(spi);
> =

> =A0=A0=A0=A0=A0=A0=A0=A0/* make sure ops on existing fds can abort cleanl=
y */
> =A0 =A0 =A0 =A0 spin_lock_irq(&spidev->spi_lock);
> =A0 =A0 =A0 =A0 spidev->spi =3D NULL; =A0 =A0<<<<<< this line is crashing
> =

> spidev is NULL, thus the crash.

Hmm, who would want to remove this driver?  :)

Looks like spi_set_drvdata() isn't getting called.  This
probably got goofed when some funkier crashes got fixed;
unless it's been there forever...



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
