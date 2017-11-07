From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [butterfly_attach] WARNING: CPU: 0 PID: 198 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x71/0x97
Date: Tue, 7 Nov 2017 08:49:46 -0800
Message-ID: <CA+55aFyxgvzPWiQgRjg1n-MNQe5O6xU0MtKQ9cq1OppJ-2sEXQ@mail.gmail.com>
References: <20171107102450.lgaujtc7f3dftvvb@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171107102450.lgaujtc7f3dftvvb@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 7, 2017 at 2:24 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>
> FYI this happens in v4.14-rc8 -- it's not necessarily a new bug.

Yeah, very doubtful. Nobody has touched that spi-butterfly driver in
about two years.

> [   13.141240] sysfs: cannot create duplicate filename '/devices/pnp0/00:04/spi_master/spi42'
> [   13.142495] ------------[ cut here ]------------
> [   13.143284] WARNING: CPU: 0 PID: 198 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x71/0x97
> [   13.199758] Call Trace:
> [   13.200072]  sysfs_create_dir_ns+0xcf/0xef
> [   13.200638]  kobject_add_internal+0x14c/0x43d
> [   13.201291]  kobject_add+0xbe/0xdf
> [   13.201696]  device_add+0x155/0x6f0
> [   13.202566]  spi_register_controller+0x21b/0x618
> [   13.203077]  spi_bitbang_start+0x14f/0x173
> [   13.203587]  butterfly_attach+0x179/0x303
> [   13.204956]  driver_check+0x25/0x2f
> [   13.205338]  bus_for_each_drv+0x7c/0xca
> [   13.205797]  parport_announce_port+0x122/0x174
> [   13.206665]  parport_pc_probe_port+0x987/0xabb [parport_pc]

I'm not sure why that driver even gets initialized under qemu. I'm
assuming it just tries to attach to any parport.

Mark, should it have a stricter check perhaps? Or should this driver
perhaps simply not be loaded by the zeroday robot?

                     Linus
