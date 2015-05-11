From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting queue_kthread_work before the message is unmapped
Date: Mon, 11 May 2015 21:27:35 +0200
Message-ID: <8F4019F0-7C56-4C9C-9193-A2A23B533165@martin.sperl.org>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org> <20150508221309.GK2761@sirena.org.uk> <352560EA-A323-449B-8F37-6066328D2081@martin.sperl.org> <20150511180016.GU3458@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	=?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150511180016.GU3458-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 11.05.2015, at 20:00, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
>> * dummy_RX/TX get allocated/released even when can_dma returns false
>>  should only run this =E2=80=9Cmapping if necessary. I guess that it=
 is mostly
>>  usefull for DMA transfers - PIO drivers typically implement this vi=
a
>>  a simple if when tx/rx_buf is NULL.
>=20
> No, it's supposed to be usable for PIO too - it can keep logic simple=
r.
but only slightly - it is a simple
  (xfer->tx_buf) ? xfer->tx_buf[i] : 0
so I do not see a huge difference.

> Indeed, just having a page that gets reused would be better.  I'm hop=
ing
> that someone who needs this will get around to optimizing it at some
> point.

I could possibly look into that, but it goes against the point you
made above about PIO.
Either we allocate the memory completely and make it work for PIO.
Or we only create a scatter/gather list of the same page and leave
tx_buf =3D=3D NULL.

So unless we have a separate flag to say we only need it for DMA,
then we have to keep the the current logic with allocation or we break
other drivers.

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
