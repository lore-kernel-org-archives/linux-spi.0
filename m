From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] spi: make sure all transfer has bits_per_word set
Date: Mon, 12 Nov 2012 11:03:56 +0100
Message-ID: <CAOiHx=nEmd9dQ297Oho=gmZTYfYgJ3o_+J2OFK=sRuRYNqzPxg@mail.gmail.com>
References: <1352452005-13789-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com,
	spi-devel-general@lists.sourceforge.net, swarren@nvidia.com,
	linux-kernel@vger.kernel.org,
	Stephen Warren <swarren@wwwdotorg.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352452005-13789-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 9 November 2012 10:06, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> When spi client does the spi transfer and does not sets
> the bits_per_word for each transfer then set it as default
> of spi device in spi core before calling low level transfer.

I like that (not that it counts ... )!

> Removing the similar code from spi-tegra20-slink driver as
> it is not required.

Not sure if this should be part of *this* patch.
Also spi-tegra20-slink isn't the only one fixing up the bits_per_word
for transfers, so it would be nice if you could remove it from the
other drivers, too.

In a future patch, maybe even do the same with speed_hz?

Regards
Jonas
