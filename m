From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 12:04:12 +0200
Message-ID: <553E099C.4070208@redhat.com>
References: <cover.1430034797.git.hramrach@gmail.com> <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com> <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com> <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com> <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com> <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com> <20150427093618.GL22845@sirena.org.uk>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
        Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDRZXY4CYYORBJUT7CUQKGQE4CLLZPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150427093618.GL22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 27-04-15 11:36, Mark Brown wrote:
> On Sun, Apr 26, 2015 at 04:14:33PM +0200, Michal Suchanek wrote:
>> On 26 April 2015 at 14:51, Maxime Ripard
>
>>> No, you add a compatible for the device that is connected to the bus
>>> through that slot.
>
>> There is no device connected in the slot by design. The slot is there
>> for connecting random stuff you find in your mailbox or other drawers
>> and boxes.
>
> You should be using device tree overlays to describe what actually ended
> up getting connected there.

Have you seen my mail about the raspberry pi use-case? Using dt-overlays
simply is not an acceptable answer there. There are legitimate use-cases
for a "generic spi bus" concept with the bus only being accessible via
spidev.

Blocking this use-case because you do not believe it is a valid use-case
is not going to help, this will just lead to the custom distros these
boards are shipping doing some ugly hack, which is not what we want
IMHO.

I hope that with the raspberry pi 2 the raspberry pi-s will eventually
go fully devicetree / multi-platform kernel so that they can be supported
ootb by distros which only want to ship a single multi-platform kernel
like Debian, but that does require us to solve problems like this one.

Regards,

Hans
