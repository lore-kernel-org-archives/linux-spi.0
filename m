From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting queue_kthread_work before the message is unmapped
Date: Sat, 9 May 2015 08:40:12 +0200
Message-ID: <352560EA-A323-449B-8F37-6066328D2081@martin.sperl.org>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org> <20150508221309.GK2761@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	=?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150508221309.GK2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 09.05.2015, at 00:13, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Fri, May 08, 2015 at 10:02:44PM +0200, Martin Sperl wrote:
>=20
>> Based on the findings by Noralf, the following solves the issue:
>=20
> Can you please post this upstream as a proper submission so I can rev=
iew
> and apply it (I'm not going to look at it properly right now, it's ju=
st
> gone 11pm, but at first glance it doesn't ring any alarm bells)?
>=20
>> Note that I am not sure about the locking, so I left unmap outside t=
he
>> lock for now.
>=20
> It needs to be, you can't do anything big like unmapping in a
> non-sleeping context.

Well, right now it is not in a locking context but outside, so
I wonder if it is really needed, but then for spi_finalize_current_mess=
age
it is not specified if it can also get run from interrupt context or no=
t.

I will do something quick now, but I guess we should revisit the
SPI_MASTER_MUST_RX/TX situation as there are some side-effects
that may not be intended or performance friendly like:

* dummy_RX/TX get allocated/released even when can_dma returns false
  should only run this =E2=80=9Cmapping if necessary. I guess that it i=
s mostly
  usefull for DMA transfers - PIO drivers typically implement this via
  a simple if when tx/rx_buf is NULL.
* dummy_tx/rx get allocated/released for every spi_message, which is
  wasting CPU
* we allocate spi_transfer->len bytes to this dummy buffer and with a
  spi-transfer of 16MB this would try to allocate another 16MB - and po=
ssibly
  fail...
  Here maybe a fixed allocated (and mapped) buffer of master->max_dma_l=
en
  could be helpfull that would get reused multiple times in the scatter=
/gather
  list to minimize the memory footprint.
  Ideally there would be support for this inside dma-engine in the form=
 of
  a flag when calling dmaengine_prep_slave_sg to indicate that data com=
es
  from /dev/zero or goes to /dev/null, as some silicon dma-engines
  (like bcm2835) supports such types of transfers in hardware.

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
