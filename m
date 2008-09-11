From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
	deasserting CS on PIO mode
Date: Thu, 11 Sep 2008 10:41:20 -0700
Message-ID: <200809111041.20900.david-b@pacbell.net>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>
	<48A9C515.3000908@whoi.edu>
	<6669365c0808181227k2fa01d6fu570cebc10630f55d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6669365c0808181227k2fa01d6fu570cebc10630f55d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Catching up on old mail ...

On Monday 18 August 2008, Daniel Ribeiro wrote:
> As I already said, i am converting a working driver from ssp.c=B4s
> ssp_read_word/ssp_write_word to pxa2xx_spi. The driver works just
> fine with:
> =

> gpio_set_value(cs, 0);
> ssp_write_word(&ssp_dev, data);
> ssp_read_word(&ssp_dev, &ret);
> gpio_set_value(cs, 1);

That is, 64 bit times ... two sequential word transfers.


> After the conversion i ended with this code:
>
> static int ezx_pcap_putget(u32 *data)
> {
> =A0 =A0 =A0 =A0 struct spi_transfer t;
> =A0 =A0 =A0 =A0 struct spi_message m;
> =

> =A0 =A0 =A0 =A0 spi_message_init(&m);
> =A0 =A0 =A0 =A0 t.len =3D 4;
> =A0 =A0 =A0 =A0 t.tx_buf =3D (u8 *)data;
> =A0 =A0 =A0 =A0 t.rx_buf =3D (u8 *)data;
> =A0 =A0 =A0 =A0 t.bits_per_word =3D 32;

That is, 32 bit times ... two *parallel* word transfers.


> =A0 =A0 =A0 =A0 spi_message_add_tail(&t, &m);
> =A0 =A0 =A0 =A0 return spi_sync(pcap.spi, &m);
> }

So "deasserting CS too early" was what you *requested* and
it's no wonder the driver did just that.  =


You could instead

    return spi_write_then_read(pcap.spi, data, 4, data, 4);

to get the sequential (not concurrent!) I/O you need.  Be
careful of byte ordering, of course; you probably should
set spi->bits_per_word to 32 and then spi_setup(), as part
of your driver init.

- Dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
