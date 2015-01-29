From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
Date: Thu, 29 Jan 2015 23:14:46 +0100
Message-ID: <CAPybu_0OWLZeEFMByrrDg7HOfjAYbOnAoazLac-E8KV-mKSJSg@mail.gmail.com>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
 <CAMuHMdX5CMH0Q5S_BBjb-F-kJfzkTS+sP9H-FDe_K_gFRxK7pw@mail.gmail.com>
 <CAPybu_3O3Rcq1Rvxvbpc-GOSs+VbO74_u+vfH+UtXjLAQjWLQA@mail.gmail.com> <2800334.5ezTSQFkNQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2800334.5ezTSQFkNQ@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Arnd

On Thu, Jan 29, 2015 at 11:11 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> > I think the definitions in include/asm-generic/iomap.h are actually wrong,
>> > as they lack a const:
>> >
>> >     extern unsigned int ioread8(void __iomem *);
>> >     extern unsigned int ioread16(void __iomem *);
>> >     extern unsigned int ioread16be(void __iomem *);
>> >     extern unsigned int ioread32(void __iomem *);
>> >     extern unsigned int ioread32be(void __iomem *);
>> >
>> > Note that the definitions in include/asm-generic/io.h do have the const:
>> >
>> >     static inline u8 ioread8(const volatile void __iomem *addr)
>> >     static inline u16 ioread16(const volatile void __iomem *addr)
>> >     static inline u32 ioread32(const volatile void __iomem *addr)
>> >     static inline u16 ioread16be(const volatile void __iomem *addr)
>> >     static inline u32 ioread32be(const volatile void __iomem *addr)
>>
> I think we don't need the 'volatile' keyword here. The main reason
> we have it on readl() is to shut up the compiler when dealing with
> ancient driver code that annotates iomem pointers as volatile.
>
> This is generally considered a (minor) driver mistake though, and
> modern drivers that for some reason use ioread*() typically don't
> do that (or they get a warning).

What about the different return type? u8 vs int
Thanks

-- 
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
