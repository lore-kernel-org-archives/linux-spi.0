From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH v2 3/6] mtd: m25p80: add support to
 parse the SPI flash's partitions
Date: Tue, 10 Aug 2010 10:29:36 +0200
Message-ID: <OF0D24DC16.E1FE65D2-ONC125777B.002E544A-C125777B.002EA7C2@transmode.se>
References: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
	<796604.30863.qm@web180307.mail.gq1.yahoo.com>
	<AANLkTi=FGf9gbWDkO4qs01Z+qkip+Zm11=Jc4wHu3G8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linuxppc-dev-mnsaURCQ41uSOrVYXZrec+piUIM3Gm7n@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=FGf9gbWDkO4qs01Z+qkip+Zm11=Jc4wHu3G8b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> On Tue, Aug 10, 2010 at 1:14 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wro=
te:
> >
> >
> > --- On Mon, 8/9/10, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> >
> >
> >> > + =A0 =A0 =A0 nr_parts =3D
> >> of_mtd_parse_partitions(&spi->dev, np, &parts);
> >
> > Let's keep OF-specific logic out of drivers like
> > this one ... =A0intended to work without OF.
> >
> > NAK on adding dependencies like OF to drivers
> > and other infrastructure that starts generic.

Agreed.

>
> The OF hooks compile to no-ops when CONFIG_OF is disabled.  I've been
> very careful about that.

OF should not be in the drivers, one should be able use some other method
than OF.


---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
