From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Tue, 28 Apr 2015 16:35:02 +0200
Message-ID: <CAOMqctSOZ5RoL+fZoywR8JNQx81OxeZw5X9Cy7KUB46nmS2nmw@mail.gmail.com>
References: <553CCABA.3090504@redhat.com> <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <20150427101601.GN22845@sirena.org.uk>
 <20150427173036.GA10950@lukather> <20150427180728.GW22845@sirena.org.uk>
 <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com> <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
 <28a25eda-bba0-4a2e-9890-b3d3bef7ac7e@googlegroups.com> <20150428141205.GG10950@lukather>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBQFV72UQKGQEKYNDUOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150428141205.GG10950@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 28 April 2015 at 16:12, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Tue, Apr 28, 2015 at 07:03:16AM -0700, Eric D. wrote:
>> Hi,
>>
>> I give Maxime's patch a try and got 4 spidev devices :
>> /dev/spidev32766.[0-3]
>>
>> root@bpi:~# ls -lh /dev/spidev*
>> crw------- 1 root root 153, 0 Apr 28 15:52 /dev/spidev32766.0
>> crw------- 1 root root 153, 1 Apr 28 15:52 /dev/spidev32766.1
>> crw------- 1 root root 153, 2 Apr 28 15:52 /dev/spidev32766.2
>> crw------- 1 root root 153, 3 Apr 28 15:52 /dev/spidev32766.3
>>
>> Shouldn't they be numbered from like spidev0.[0-3].
>> Is this an udev problem ? any clues ?
>
> You're missing an SPI alias in the DT.

Indeed, adding some SPI aliases makes the device nodes tidier:

        aliases {
                serial0 = &uart0;
                serial1 = &uart2;
                serial2 = &uart3;
                spi0 = &spi0;
                spi1 = &spi1;
                spi2 = &spi2;
        };

However, SPI usage examples I have seen showed some random high number.

Thanks

Michal
