From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: slink-tegra20: move runtime pm calls to transfer_one_message
Date: Fri, 08 Mar 2013 10:05:28 -0700
Message-ID: <513A1A58.9060102@wwwdotorg.org>
References: <1362723679-1155-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362723679-1155-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/07/2013 11:21 PM, Laxman Dewangan wrote:
> The prepare_transfer_hardware() is called in atomic context and
> calling synchronous runtime pm calls can create scheduling deadlock.
> 
> Therefore, in place of calling runtime PM calls from prepare/unprepare
> message transfer, calling this in transfer_one_message().

Tested-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This does fix some slightly intermittent lockups/crashes for me when
erasing and re-writing the SPI flash on Cardhu.
