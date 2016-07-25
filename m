From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/13] sunxi spi fixes
Date: Mon, 25 Jul 2016 10:03:14 +0200
Message-ID: <CAOMqctQybJoOfUHGtpmpB_koQ=iY+GpQ_BOL2o0QBbwC_HXC0g@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com> <20160613195716.GD9354@lukather>
 <CAOMqctS6ZQ3_a97sE2e7H34ZCny2aDE38V1tQA=-SBZwF2sbDQ@mail.gmail.com> <20160725073204.GD7419@lukather>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timo Sigurdsson <public_timo.s-fWgRPtSzPNU3WX+qO2AYSQ@public.gmane.org>, Jonathan Liu <net147-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TZNg+MwTxZMZA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBB2MP266AKGQEQQP3GTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160725073204.GD7419@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hello,

On 25 July 2016 at 09:32, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Fri, Jun 17, 2016 at 12:34:44PM +0200, Michal Suchanek wrote:
>> Hello,
>>
>> On 13 June 2016 at 21:57, Maxime Ripard
>> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> > On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
>> >> Hello,
>> >>
>> >> This is update of the sunxi spi patches that should give full-featured SPI
>> >> driver.
>> >>
>> >> First three patches fix issues with the current driver and can be of use for
>> >> stable kernels so adding cc for those.
>> >>
>> >> I merged the sun4i and sun6i driver because there several issues that need to
>> >> be fixed in both separately and they are even out of sync wrt some fixes.
>> >> I guess some of the merge patches can be squashed.
>> >>
>> >> I tested this with A10s Olinuxino Micro. I have no sun6i device so I cannot
>> >> tell if that side was broken by this patchset - especially the last patch that
>> >> adds DMA was afaik never tested on sun6i.
>> >
>> >
>> > For the record, I'm still very much opposed to such a merge.
>>
>> What is the reason against the merge? I did not find the original
>> discussion.
>
> I really prefer some code that is concise and clear but a little
> duplicated over some code that shares every possible lines of code but
> is a giant mess impossible to understand.

Yes, it's been tried. In the case of this driver there is more duplication
than differences. Also bitrot due to different variants receiving different
updates and fixes crept in already.

Adding the remap layer certainly does not make the driver easier to
understand but it's not becoming giant mess either.

>
> I just came across the reg_field stuff in regmap that would allow to
> partially address that problem though, there's still the bit indices
> issue to overcome though.
>
>> I tried to rename everything in the drivers from sun4i and sun6i to
>> sunxi to look at a clean diff and found about 5 differences 2 of which
>> look like a bug.
>
> It's hard to tell without testing.

I tested the merged (and separate) driver on a H3 board and found a
type bug in the remap layer.

I also found I can transfer at most 68 bytes without DMA although
the manuals claim 128 byte FIFO. DMA transfers weren't very reliable
which may or may not be a wiring issue. I have seen similar issues
intermittently with SPI on A10s.

Thanks

Michal
