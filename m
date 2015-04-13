From: Pelle Nilsson <per.nilsson@xelmo.com>
Subject: Re: [PATCH 1/1] spi: altera: Add empty implementation of setup_transfer
 callback
Date: Mon, 13 Apr 2015 11:45:41 +0200
Message-ID: <552B9045.4040709@xelmo.com>
References: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com> <1428591822-24279-2-git-send-email-per.nilsson@xelmo.com> <20150409154045.GZ6023@sirena.org.uk> <55269FDC.8040306@xelmo.com> <20150409161059.GA6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	nios2-dev@lists.rocketboards.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150409161059.GA6023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2015-04-09 18:10, Mark Brown wrote:
> On Thu, Apr 09, 2015 at 05:50:52PM +0200, Pelle Nilsson wrote: What
> I'm trying to suggest is that you're perhaps fixing the wrong 
> problem - make the callback optional if there's a good reason for
> it.

Yes, the callback can be made optional, I'll send a new patch.
