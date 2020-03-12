From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe
Date: Thu, 12 Mar 2020 09:11:44 -0300
Message-ID: <CAOMZO5CJ7G7yJZEEPfsm1P2SnrJ7kmOPmZCWiKwrvDZjPNOnWw@mail.gmail.com>
References: <20200312113154.GC20562@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20200312113154.GC20562@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dan,

On Thu, Mar 12, 2020 at 8:33 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The platform_get_resource_byname() function returns NULL on error, it
> doesn't return error pointers.
>
> Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The commit message for commit d166a73503ef ("spi: fspi: dynamically
> alloc AHB memory") is not very good.  Why is it necessary to allocate
> the AHB memory dynamically instead of during probe?  Also I suspect that

Agreed and I made the same comment during review:
https://patchwork.kernel.org/patch/11361581/

Thanks
