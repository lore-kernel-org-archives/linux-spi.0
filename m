From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] spi: spidev_test: Added functionalities
Date: Fri, 27 Feb 2015 15:11:17 -0700
Message-ID: <20150227151117.15a79baa@lwn.net>
References: <1424891324-24784-1-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
To: Adrian Remonda <adrianremonda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424891324-24784-1-git-send-email-adrianremonda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 25 Feb 2015 20:08:44 +0100
Adrian Remonda <adrianremonda@gmail.com> wrote:

> This is a patch that add functionalities to the spidev_test tool found
> in Documentation/spi/spidev_test.c.

This seems good.  But our hope is to move useful code out of
Documentation; care to submit a patch putting it properly somewhere under
tools/?

(Meanwhile, I've applied this one).

Thanks,

jon
