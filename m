From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [GIT PULL] spi fixes for v3.15
Date: Fri, 11 Apr 2014 13:41:56 -0700
Message-ID: <CA+55aFxCubywWSLdhAva9dvj26=o4WkaVnhYjgEKrEuMuaFo+g@mail.gmail.com>
References: <20140411105604.GR6518@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140411105604.GR6518-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Apr 11, 2014 at 3:56 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> Same issue as on the regulator pull request with the entire diffstat for
> the original pull request for this merge window has appeared - like I
> say I will try to fix the scripts as it's annoying and unclear.

Yeah, looking at this, the problem does seem to be that extraneous
merge. I'm not sure why you did that "Merge tag 'spi-v3.15' into
spi-linus" at all, but it basically acts as an indirect back-merge
giving you two different merge bases.

You seem to start your development by doing a merge of that tag that
you sent me. Why? Why not just start *at* the tag you sent me, not at
that extraneous merge of that tag and v3.14.

               Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
