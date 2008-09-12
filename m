From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
 deasserting CS on PIO mode
Date: Thu, 11 Sep 2008 22:53:48 -0400
Message-ID: <48C9D9BC.1050306@whoi.edu>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>	
	<48A9C515.3000908@whoi.edu>	
	<6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>	
	<200809111041.20900.david-b@pacbell.net>
	<1221184432.5078.19.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1221184432.5078.19.camel@brutus>
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

Daniel Ribeiro wrote:
> Em Qui, 2008-09-11 =C3 s 10:41 -0700, David Brownell escreveu:
> Yes, i guess i really should use spi_setup().
> My current code is:
> =

>         spi_message_init(&m);
>         t.len =3D 4;
>         t.tx_buf =3D (u8 *)data;
>         t.rx_buf =3D (u8 *)data;
>         t.bits_per_word =3D 32;
>         t.delay_usecs =3D 0;
>         t.cs_change =3D 0;
>         t.speed_hz =3D 13000000;
>         spi_message_add_tail(&t, &m);
>         return spi_sync(pcap.spi, &m);
> =

> I noted that if i dont set .delay_usecs it gets a default huge value,
> same with .speed_hz, it dont use spi_board_info->max_speed_hz as
> default. Would calling spi_setup() on my driver init solve this? Or is
> this yet another issue?

In a past message, you showed the automatic declarations that went with
the above code:

>	struct spi_transfer t;
>	struct spi_message m;

While spi_message_init() zeros the memory in "m", you don't show any
code above, other than your assignments, that clears the memory in "t".
Thus, if you omit the assignments for t.delay_usecs or t.speed_hz (or
any other member of t), then you are passing uninitialized memory.  You
could use memset to clear t, or dynamically allocate zeroed memory.

Normally, you use the per-transfer values:

	t.bits_per_word
	t.speed_hz

only when you need to make them different from the default values set
when you previously called spi_setup(), and the values of:

	t.delay_usecs
	t.cs_change

when you need control over the changes in CS between transfers, and
optionally a delay prior to changes in CS.  Errors in handling these
last two were addressed by the patch you tested, and which David pushed
recently.

-- =

Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=3D7212
http://www.whoi.edu/hpb/Site.do?id=3D1532
http://www.whoi.edu/page.do?pid=3D10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
