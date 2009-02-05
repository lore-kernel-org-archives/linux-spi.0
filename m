From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] Blackfin SPI Driver: use bfin_spi_ prefix on all
 functions
Date: Thu, 5 Feb 2009 14:12:45 -0800
Message-ID: <20090205141245.2945141e.akpm@linux-foundation.org>
References: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
	<1233828453-13311-2-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, vapier.adi@gmail.com,
	cooloney@kernel.org
To: Bryan Wu <cooloney@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755030AbZBEWNP@vger.kernel.org>
In-Reply-To: <1233828453-13311-2-git-send-email-cooloney@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu,  5 Feb 2009 18:07:29 +0800
Bryan Wu <cooloney@kernel.org> wrote:

> Do this because when things crash, we get simple names like "setup" and
> "start_queue" which is pretty difficult to trace back to the real thing:
> the spi driver
> 

As usual, the driver core guys have gone trompling all over other people's code
and your patch doesn't apply to linux-next.

11 out of 61 hunks FAILED -- saving rejects to file drivers/spi/spi_bfin5xx.c.rej
