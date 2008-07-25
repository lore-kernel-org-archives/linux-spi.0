From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH v3 0/4 REPOST] OF infrastructure for SPI devices
Date: Fri, 25 Jul 2008 10:46:11 -0400
Message-ID: <9e4733910807250746g436307d7sbbf799b73a9f2c67@mail.gmail.com>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
To: "Grant Likely" <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753142AbYGYOqX@vger.kernel.org>
In-Reply-To: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 7/25/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> I don't know what to do with these patches.  I'd really like to see them
>  in .27, and now that akpm has cleared his queue, the prerequisite patch
>  has been merged so they are ready to go in.  However, even though there
>  has been favourable reception on the SPI and linuxppc lists for these
>  changes I don't have any acks from anybody yet.

I have compatible hardware but it has an MMC card socket hooked up. I
haven't figured out yet how to get this driver hooked to the MMC
subsystem and make the file system on the card work.  (I've been
working on ALSA).

I believe I need this:
http://lkml.org/lkml/2008/6/5/209

Then I need to get everything hooked together. Point me in the right
direction and I can help with testing.


>
>  David, can you please reply on if you are okay with these patches
>  getting merged?  If so, do you want me to merge them via my tree, or
>  do you want to pick them up?
>
>  Thanks,
>  g.
>
>  --
>  Grant Likely, B.Sc. P.Eng.
>  Secret Lab Technologies Ltd.
>
> --
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Jon Smirl
jonsmirl@gmail.com
