From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] spi: orion: cosmetics - alias long direct_access
 variables
Date: Mon, 6 Aug 2018 22:06:40 +0200
Message-ID: <20180806200640.GL9372@lunn.ch>
References: <20180806195002.15156-1-zertsekel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
To: Kosta Zertsekel <zertsekel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806195002.15156-1-zertsekel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 06, 2018 at 10:50:02PM +0300, Kosta Zertsekel wrote:
> This change increases the source code readability.
> Instead of using `spi->child[cs].direct_access.XXX` use `dacc->XXX`.

Hi Kosta

You forgot to update this line.

Please wait a week to allow others to comment, then submit a v3, and
include:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
