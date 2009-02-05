From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 01/16] Blackfin SPI Driver: ensure cache coherency before  doing DMA
Date: Thu, 5 Feb 2009 15:51:13 -0800
Message-ID: <200902051551.14146.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org> <200811201405.06811.david-b@pacbell.net> <386072610902050130k27c6d7far752ac49183bf36ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Frysinger <vapier.adi@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Vitja Makarov <vitja.makarov@gmail.com>
To: Bryan Wu <cooloney@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755983AbZBEXv1@vger.kernel.org>
In-Reply-To: <386072610902050130k27c6d7far752ac49183bf36ae@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 05 February 2009, Bryan Wu wrote:
> As you acked this patchset, is that possible to merge it?
> Or need Andrew to keep them in -mm for a while.

ISTR *NOT* acking the whole series though.  In fact, I recall
giving a generic NAK part way through because of patches that
didn't include comments (after manually NAKing many individual
patches) and ones where $SUBJECT didn't match the patch comments.
Plus even a few which seemed to be wrong.

(And I've said the same thing about Blackfin patches before,
too.  Please help the message get through to your co-workers:
make sure the patches come with useful public descriptions.)

At this point, best to resend the whole series, with the
updates I requested.  The few patches which I did ack can
include that ack.

- Dave
