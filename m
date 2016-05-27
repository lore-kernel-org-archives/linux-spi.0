From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2, 3/4] arm: dts: Add bcm-nsp and bcm958625k support
Date: Fri, 27 May 2016 13:47:31 -0700
Message-ID: <20160527204731.GA121328@google.com>
References: <1464380097-25125-1-git-send-email-kdasu.kdev@gmail.com>
 <1464380097-25125-3-git-send-email-kdasu.kdev@gmail.com>
 <5748ADDE.2090402@broadcom.com>
 <CAGVrzcZQMSVo4LvbqJ1jcx-f7M+psWQeHQfiRS3-L7JN+C_zuw@mail.gmail.com>
 <CAGVrzcYfNTZWDAK8tW-HaALYXJo5zPjiWOxsB0mntCVdjnUwUg@mail.gmail.com>
 <CAGVrzcbhoD1zDtvBXdm8DgzzXeP0MxAMtXduZMYv+BwpiwtgkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGVrzcbhoD1zDtvBXdm8DgzzXeP0MxAMtXduZMYv+BwpiwtgkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Florian,

(HTML mail. What is this??)

On Fri, May 27, 2016 at 01:33:20PM -0700, Florian Fainelli wrote:
>    On May 27, 2016 1:28 PM, "Scott Branden"
>    <[1]scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> 
>    >> +&qspi {
>    >> +       bspi-sel = <0>;
>    >> +       flash: m25p80@0 {
>    >> +               #address-cells = <1>;
>    >> +               #size-cells = <1>;
>    >> +               compatible = "m25p80";
>    >> +               reg = <0x0>;
>    >> +               spi-max-frequency = <12500000>;
>    >> +               m25p,fast-read;
>    >> +               spi-cpol;
>    >> +               spi-cpha;
>    >> +
>    >> +               partition@0 {
>    >> +                       label = "boot";
>    >> +                       reg = <0x00000000 0x000a0000>;
>    >> +               };
>    >> +
>    >> +               partition@1 {
>    >> +                       label = "env";
>    >> +                       reg = <0x000a0000 0x00060000>;
>    >> +               };
>    >> +
>    >> +               partition@2 {
>    >> +                       label = "system";
>    >> +                       reg = <0x00100000 0x00600000>;
>    >> +               };
>    >> +
>    >> +               partition@3 {
>    >> +                       label = "rootfs";
>    >> +                       reg = <0x00700000 0x01900000>;
>    >> +               };
>    >
>    >
>    > The partitions are applications specific so should be passed on the
>    boot command line rather than embedded in the dts file.

Scott kinda has a point; they can be application specific, and so in
some cases, you might want to avoid putting this description in DT, at
least if there are good alternatives. The command line may or may not be
a good alternative (I don't think it's a very good one).

>    Partitions are typically part of the platform definition and are
>    suitable for being in Device Tree. AFAICT there is not a good way to
>    supply partitions in an OF configuration other than putting them in DT
>    at the moment. There is also a lot of platform inconsistency whether
>    the command line is appended, extended or overrides the command line in
>    the Device Tree, so I would not really consider this an issue here.

My intention is to allow cmdline to take priority, so you could have
application-specific overrides. If that doesn't work correctly, then
I'd consider it a bug. I know that has irked some people (e.g.,
OpenWRT?), where they deal with products where they may not control the
command line. But that's a separate issue IMO.

You might want to take a look at supporting a partition parser, if this
really is so application-specific. I had all the pieces working late
last year:

https://lkml.org/lkml/2015/12/5/9

but I unfortunately got distracted once the conversation on bindings
derailed:

https://lkml.org/lkml/2015/12/12/31

I should probably revive that...

Anyway, if you utilize that, then you can specify which parser(s) are
valid for your platform, rather than specifying the exact partition
layout.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
