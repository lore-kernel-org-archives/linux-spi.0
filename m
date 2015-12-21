From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v2 1/8] spi: core: add spi_message_dump and spi_transfer_dump
Date: Mon, 21 Dec 2015 20:15:03 +0100
Message-ID: <67394561-E7F6-479B-86D7-5D5E25DCF242@martin.sperl.org>
References: <1450698772-2379-1-git-send-email-kernel@martin.sperl.org> <1450698772-2379-4-git-send-email-kernel@martin.sperl.org> <CAHp75Vc+THQ6xojJ0cMcjuLxe=KPNHB7KB2pa0yqhr-WnNga4g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vc+THQ6xojJ0cMcjuLxe=KPNHB7KB2pa0yqhr-WnNga4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 21.12.2015, at 13:42, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>> +               /* format the next 16 bytes */
>> +               snprintf(hexdata, sizeof(hexdata), "%16ph", ptr + i)=
;
>> +
>> +               /* truncate the unnecessarily printed bytes */
>=20
> Again, you don't need the intermediate buffer along with this all
> stuff. Just use %*ph properly (hint: star is put here and elsewhere o=
n
> purpose).
>=20
> drivers/hid/i2c-hid/i2c-hid.c:187:      i2c_hid_dbg(ihid, "%s:
> cmd=3D%*ph\n", __func__, length, cmd->data);
>=20
That is what was missing - did not find any sensible example that showe=
d
that this is possible and also Documentation/printk-formats.txt does
not mention this explicitly either.


>> +               l =3D min_t(size_t, len - i, spi_dump_bytes_per_line=
) * 3 - 1;
>> +               hexdata[l] =3D 0;
>> +
>> +               /* and print data including address and offset */
>> +               dev_info(&spi->dev, "%soff=3D0x%.5zx ptr=3D0x%pK: %s=
\n",
>> +                        prefix, i, ptr + i, hexdata);
>> +       }
>> +}
>> +
>> +static void spi_transfer_dump_buffer(struct spi_device *spi, char *=
prefix,
>> +                                    const void *ptr, size_t len,
>> +                                    size_t head_len, size_t tail_le=
n)
>> +{
>=20
> The function body looks too complicated. Can you describe what
> function does in different cases?
>=20
Can add kernel do here

>> +               if (head_len | tail_len)
>=20
> I think || looks a bit more logical here and below.
true...

>=20
>> +                       spi_transfer_dump_buffer(spi, "\t",
>> +                                                xfer->tx_buf, xfer-=
>len,
>> +                                                head_len, tail_len)=
;
>> +       }
>> +       if (xfer->rx_buf) {
>> +               dev_info(dev, "    rx_buf:      %pK\n", xfer->rx_buf=
);
>> +               if (xfer->rx_dma)
>> +                       dev_info(dev, "    rx_dma:      %pad\n",
>> +                                &xfer->rx_dma);
>> +               if (head_len | tail_len)
true...
>=20
>> +                       spi_transfer_dump_buffer(spi, "\t",
>> +                                                xfer->rx_buf, xfer-=
>len,
>> +                                                head_len, tail_len)=
;
>=20
> Is the DMA buffer is in coherent memory? Otherwise you have to call
> dma_sync for it before reading on CPU side.

It has to be because it is not necessary that DMA is used at all.
Also the =E2=80=9Cfeature=E2=80=9D is depreciated anyway and Mark wants=
 to see it going away.

Thanks again for the review=E2=80=A6

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
