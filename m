From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Date: Sat, 8 Feb 2020 00:04:29 +0200
Message-ID: <CAHp75VduJn=kMuriGNAGk1ZrL4b2LpqEn5c8AC=PHFKrgoz=vg@mail.gmail.com>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com> <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com> <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
 <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com> <CAHp75Vf6HJw=SpK9_HUgcMaaabs5pZEybP4SS-gc1wz5GRcqeg@mail.gmail.com>
 <cd8a7279-beb2-39e6-58e6-6ea505665547@linux.vnet.ibm.com> <CAHp75VdO2+Kkgo1Nv3EJXTMqP6Y7XgLVXtRvURk6Zz0p=R9zNQ@mail.gmail.com>
 <ca8a832e-ceeb-3ce1-9807-96ee41e0f166@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>,
        Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
To: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ca8a832e-ceeb-3ce1-9807-96ee41e0f166-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Feb 7, 2020 at 11:04 PM Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:
> On 2/7/20 2:34 PM, Andy Shevchenko wrote:
> > On Fri, Feb 7, 2020 at 10:04 PM Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:
> >> On 2/7/20 1:39 PM, Andy Shevchenko wrote:
> >>> On Fri, Feb 7, 2020 at 9:28 PM Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:
> >>>> On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> >>>>> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
> >>>>>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> >>>>>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> wrote:
> >>>>>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
> >
> >>>>>>>>>> +       for (i = 0; i < num_bytes; ++i)
> >>>>>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> >>>>>>>>> Redundant & 0xffULL part.
> >>>>> For me it looks like
> >>>>>
> >>>>>      u8 tmp[8];
> >>>>>
> >>>>>      put_unaligned_be64(in, tmp);
> >>>>>      memcpy(rx, tmp, num_bytes);
> >>>>>
> >>>>> put_unaligned*() is just a method to unroll the value to the u8 buffer.
> >>>>> See, for example, linux/unaligned/be_byteshift.h implementation.
> >>>> Unforunately it is not the same. put_unaligned_be64 will take the
> >>>> highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then
> >>>> 0x00ff000000000000 into tmp[1], etc. This is only correct for this
> >>>> driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes,
> >>>> then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into
> >>>> tmp[1], etc. So I think my current implementation is correct.
> >>> Yes, I missed correction of the start address in memcpy(). Otherwise
> >>> it's still the same what I was talking about.
> >>
> >> I see now, yes, thanks.
> >>
> >> Do you think this is worth a v3? Perhaps put_unaligned is slightly more
> >> optimized than the loop but there is more memory copy with that way too.
> > I already forgot the entire context when this has been called. Can you
> > summarize what the sequence(s) of num_bytes are expected usually.
> >
> > IIUC if packets small, less than 8 bytes, than num_bytes will be that value.
> > Otherwise it will be something like 8 + 8 + 8 ... + tail. Is it
> > correct assumption?
>
>
> Yes, it will typically be 8 + 8 +... remainder. Basically, on any RX,
> the driver polls for the rx register full. Once full, it will read
> however much data is left to be transferred. Since we use min(len, 8)
> then we read 8 usually, until we get to the end.

I asked that because we might have a better optimization, i.e, call
directly put_unaligned_be64() when we know that length is 8 bytes. For
the rest your approach might be simpler. Similar for the TX case.

> >>>>>>>>>> +       return num_bytes;
> >>>>>>>>>> +}

-- 
With Best Regards,
Andy Shevchenko
