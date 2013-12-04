From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/11] pinctrl: sh-pfc: r8a7791: fix msiof groups to follow GROUP
Date: Wed, 04 Dec 2013 02:23:45 +0100
Message-ID: <5040605.U30kg1BDtJ@avalon>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp> <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp> <CACRpkdYyLS3gy53GOJhEwYXh4uW_Uxa5PLF1E45OhWvUiMfYpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: takasi-y@ops.dti.ne.jp,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYyLS3gy53GOJhEwYXh4uW_Uxa5PLF1E45OhWvUiMfYpA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

On Tuesday 03 December 2013 11:08:14 Linus Walleij wrote:
> On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> > From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> > 
> > SH_PFC_PIN_GROUP(), pins[], mux[], defines
> > 
> >  clk, sync, ss1, ss2, rx, tx
> > 
> > But, msiof?_groups[] defines
> > 
> >  clk, ctrl, data
> > 
> > Fix msiof[012]_groups members to be consistent to PIN_GROUP.
> > 
> > Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> 
> This looks all right to me. Laurent is merging PFC patches for this
> kernel cycle, please make sure you include him on subsequent
> postings. Once Laurent has a finished series I'll pull it into
> the pinctrl tree.

I've applied this patch to my tree.

> I think the device tree changes part of this series can go directly
> to Simon though?

-- 
Regards,

Laurent Pinchart

