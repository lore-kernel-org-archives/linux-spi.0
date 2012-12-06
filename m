From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: sh-msiof: Add device tree parsing to driver
Date: Thu, 06 Dec 2012 14:14:15 +0000
Message-ID: <20121206141415.10BB43E0948@localhost>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com> <1352288407-20594-4-git-send-email-hechtb@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1352288407-20594-4-git-send-email-hechtb@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed,  7 Nov 2012 12:40:06 +0100, Bastian Hecht <hechtb@gmail.com> wrote:
> This adds the capability to retrieve setup data from the device tree
> node. The usage of platform data is still available.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Aside from the binding issues I've pointed out on patch 4, this change
looks fine. I'll wait for an updated patch before committing.

g.

