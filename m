From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 2/2] spi: npcm-fiu: add NPCM FIU controller driver
Date: Thu, 8 Aug 2019 17:32:32 +0200
Message-ID: <20190808173232.4d79d698@collabora.com>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
        <20190808131448.349161-3-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        vigneshr@ti.com, bbrezillon@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808131448.349161-3-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu,  8 Aug 2019 16:14:48 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:


> +
> +static const struct spi_controller_mem_ops npcm_fiu_mem_ops = {
> +	.exec_op = npcm_fiu_exec_op,

No npcm_supports_op()? That's suspicious, especially after looking at
the npcm_fiu_exec_op() (and the functions called from there) where the
requested ->buswidth seems to be completely ignored...

> +	.dirmap_create = npcm_fiu_dirmap_create,
> +	.dirmap_read = npcm_fiu_direct_read,
> +	.dirmap_write = npcm_fiu_direct_write,
> +};
> +
