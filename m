From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Date: Mon, 10 Feb 2020 22:33:49 +0200
Message-ID: <CAHp75VfpRV7UDMpPKo8Vu1PaOfLjUG24yUdkg8ip9=923cwarA@mail.gmail.com>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com> <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com> <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
 <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com> <CAHp75Vf6HJw=SpK9_HUgcMaaabs5pZEybP4SS-gc1wz5GRcqeg@mail.gmail.com>
 <cd8a7279-beb2-39e6-58e6-6ea505665547@linux.vnet.ibm.com> <CAHp75VdO2+Kkgo1Nv3EJXTMqP6Y7XgLVXtRvURk6Zz0p=R9zNQ@mail.gmail.com>
 <ca8a832e-ceeb-3ce1-9807-96ee41e0f166@linux.vnet.ibm.com> <CAHp75VduJn=kMuriGNAGk1ZrL4b2LpqEn5c8AC=PHFKrgoz=vg@mail.gmail.com>
 <3bbc98a7-838d-f57f-0478-a632ba68f500@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Eddie James <eajames@linux.ibm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
To: Eddie James <eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3bbc98a7-838d-f57f-0478-a632ba68f500@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 10, 2020 at 10:05 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> On 2/7/20 4:04 PM, Andy Shevchenko wrote:
> > On Fri, Feb 7, 2020 at 11:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >> On 2/7/20 2:34 PM, Andy Shevchenko wrote:
> >>> On Fri, Feb 7, 2020 at 10:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>> On 2/7/20 1:39 PM, Andy Shevchenko wrote:
> >>>>> On Fri, Feb 7, 2020 at 9:28 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>>>> On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> >>>>>>> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
> >>>>>>>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> >>>>>>>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>>>>>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
> >>>>>>>>>>>> +       for (i = 0; i < num_bytes; ++i)
> >>>>>>>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> >>>>>>>>>>> Redundant & 0xffULL part.
> >>>>>>> For me it looks like
> >>>>>>>
> >>>>>>>       u8 tmp[8];
> >>>>>>>
> >>>>>>>       put_unaligned_be64(in, tmp);
> >>>>>>>       memcpy(rx, tmp, num_bytes);
> >>>>>>>
> >>>>>>> put_unaligned*() is just a method to unroll the value to the u8 buffer.
> >>>>>>> See, for example, linux/unaligned/be_byteshift.h implementation.
> >>>>>> Unforunately it is not the same. put_unaligned_be64 will take the
> >>>>>> highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then
> >>>>>> 0x00ff000000000000 into tmp[1], etc. This is only correct for this
> >>>>>> driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes,
> >>>>>> then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into
> >>>>>> tmp[1], etc. So I think my current implementation is correct.
> >>>>> Yes, I missed correction of the start address in memcpy(). Otherwise
> >>>>> it's still the same what I was talking about.
> >>>> I see now, yes, thanks.
> >>>>
> >>>> Do you think this is worth a v3? Perhaps put_unaligned is slightly more
> >>>> optimized than the loop but there is more memory copy with that way too.
> >>> I already forgot the entire context when this has been called. Can you
> >>> summarize what the sequence(s) of num_bytes are expected usually.
> >>>
> >>> IIUC if packets small, less than 8 bytes, than num_bytes will be that value.
> >>> Otherwise it will be something like 8 + 8 + 8 ... + tail. Is it
> >>> correct assumption?
> >>
> >> Yes, it will typically be 8 + 8 +... remainder. Basically, on any RX,
> >> the driver polls for the rx register full. Once full, it will read
> >> however much data is left to be transferred. Since we use min(len, 8)
> >> then we read 8 usually, until we get to the end.
> > I asked that because we might have a better optimization, i.e, call
> > directly put_unaligned_be64() when we know that length is 8 bytes. For
> > the rest your approach might be simpler. Similar for the TX case.
>
>
> I just tried to implement as you suggested but I realized something: The
> value is already swapped from BE to CPU when the register is read in
> fsi_spi_read_reg. It happens to work out correctly to use
> put_unaligned_be64 on a LE CPU to flip the bytes here. But on a BE CPU,
> this wouldn't be correct I think.

Hmm... Any BE conversion op on BE architecture is no-op.
Same for LE on LE.

> Now I don't anticipate this driver
> running on a BE CPU, but I think it is weird to flip it twice, and
> better to do it manually here.
>
> What do you think Andy?



> >>>>>>>>>>>> +       return num_bytes;
> >>>>>>>>>>>> +}



-- 
With Best Regards,
Andy Shevchenko
