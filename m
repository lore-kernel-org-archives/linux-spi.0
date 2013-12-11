From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/11] ARM: shmobile: r8a7791: MSIOF platform device
Date: Wed, 11 Dec 2013 13:27:34 +0100
Message-ID: <CACRpkda=m_3Y+FcKUvAj4e1gDUuvqB4VS4bv6u-VnX4LVQQP8Q@mail.gmail.com>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
	<1385921962-19843-9-git-send-email-takasi-y@ops.dti.ne.jp>
	<CACRpkdbvrYgRh7cK0N1HrcxkYzzu9Qw4yAoQwj4f9pEf0r1qQw@mail.gmail.com>
	<20131205030235.GG21443@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org,
	"linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	"arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131205030235.GG21443-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 5, 2013 at 4:02 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> On Tue, Dec 03, 2013 at 11:12:32AM +0100, Linus Walleij wrote:

>> NAK.
>
> Hi Linus,
>
> the way that shmobile is handling moving to DT is multi-faceted.
> One such facet is that we currently maintain two ways of booting each board.
> One uses legacy-C code and initialises devices using platform devices.
> The other, which we call -reference uses DT.
>
> This patch is for the legacy-C board code to use.
>
> This has been the approach that we have been taking for about a year now.
> We have recently been giving some consideration to moving to the next stage
> which we believe is to enable devices whose drivers don't have DT bindings
> (yet) using DT in -reference. With this in place it should be possible
> to plan removal of the legacy-C board code.
>
> In the mean time I would prefer if we kept with the pattern that
> we have been using up until now.

If you get an OK from the ARM SoC maintainers on this approach I
will rest my case. I have to provide some kind of pushback you know,
lest I fear nothing ever happens...

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
