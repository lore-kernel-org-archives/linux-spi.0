From: Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH v4 0/3] Add Mediatek SPI bus driver
Date: Thu, 30 Jul 2015 21:29:28 +0200
Message-ID: <CAOiHx=nfrx4pm91MYcpn_jx3UMtpJD8nt9ptmKSFQA5YEsDL4A@mail.gmail.com>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Wed, Jul 29, 2015 at 1:04 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> Change in v4:
> 1. fix Mark Brown review comment.

You should say what you actually fixed/changed, not just that you
changed something. Also the individual patches should contain
changelogs as well (under the tear-off line (--), so one knows if
something was changed between
versions.


Jonas
