From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Sun, 26 Apr 2015 16:40:50 +0200
Message-ID: <553CF8F2.6070204@redhat.com>
References: <cover.1430034797.git.hramrach@gmail.com> <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com> <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com> <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com> <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com> <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com> <20150426143359.GI5627@lukather>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
        Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDRZXY4CYYORB67R6OUQKGQEY6BLP6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150426143359.GI5627@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi,

I've a feeling everyone in this thread is ignoring the
raspberry pi use-case. Where the board is specifically
designed for educational purposes and used with lots of
peripherals which are usually programmed from userspace
using e.g. python bindings for i2c-dev or spidev, for
such a setup we really want spidev to be loaded on the
spibus by default and we really do not have a proper
compatible for a child device.

And no having to use per device devicetree overlays
for this is not the answer, this needs to be really
really easy. With pre device-tree kernels this just
works, we should be able to match that ease of use
with devicetree.

Regards,

Hans
