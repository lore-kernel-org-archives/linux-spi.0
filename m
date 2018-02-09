From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 2/3] spi: Add spi driver for Socionext Synquacer platform
Date: Fri, 9 Feb 2018 08:13:49 +0530
Message-ID: <CABb+yY3ubLb9+VPBWHAEr4U=2WO5M1X6RL-7BTShHBELh8uXoA@mail.gmail.com>
References: <1516358213-4400-1-git-send-email-jassisinghbrar@gmail.com>
 <1516358251-4523-1-git-send-email-jassisinghbrar@gmail.com> <CAKv+Gu_Bzs8iW4xiA-N47Q_58QQcmt=VrNK2fe3URoRMcFswTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKv+Gu_Bzs8iW4xiA-N47Q_58QQcmt=VrNK2fe3URoRMcFswTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 9, 2018 at 2:12 AM, Ard Biesheuvel
<ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 19 January 2018 at 10:37,  <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> > This patch adds support for controller found on synquacer platforms.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> I added the following nodes to my SynQuacer boards:
>
>     clk_fip006_spi: spi_ihclk {
>         compatible = "fixed-clock";
>         #clock-cells = <0>;
>         clock-frequency = <125000000>;
>     };
>
>     spi@54810000 {
>         compatible = "socionext,synquacer-spi";
>         reg = <0x0 0x54810000 0x0 0x1000>;
>         clocks = <&clk_fip006_spi>;
>         clock-names = "iHCLK";
>         socionext,use-rtm;
>         socionext,set-aces;
>         #address-cells = <1>;
>         #size-cells = <0>;
>
>         tpm@0 {
>             reg = <0x0>;
>             compatible = "infineon,slb9670";
>             spi-max-frequency = <22500000>;
>         };
>     };
>
> and I end up with the following splat:
>
> [    5.741886] Unable to handle kernel paging request at virtual
> address fffffffffffffffe
> [    5.741889] Mem abort info:
> [    5.741891]   ESR = 0x96000004
> [    5.741895]   Exception class = DABT (current EL), IL = 32 bits
> [    5.741898]   SET = 0, FnV = 0
> [    5.741899]   EA = 0, S1PTW = 0
> [    5.741901] Data abort info:
> [    5.741903]   ISV = 0, ISS = 0x00000004
> [    5.741905]   CM = 0, WnR = 0
> [    5.741910] swapper pgtable: 4k pages, 48-bit VAs, pgd = 0000000042134b9d
> [    5.741913] [fffffffffffffffe] *pgd=0000000000000000
> [    5.741920] Internal error: Oops: 96000004 [#1] SMP
> [    5.741924] Modules linked in: efivars(+) gpio_keys(+)
> spi_synquacer(+) efivarfs ip_tables x_tables autofs4 ext4 crc16
> mbcache jbd2 fscrypto sd_mod ahci xhci_pci libahci xhci_hcd libata
> usbcore realtek scsi_mod netsec of_mdio fixed_phy libphy gpio_mb86s7x
> [    5.741974] CPU: 18 PID: 389 Comm: systemd-udevd Not tainted 4.15.0+ #1
> [    5.741976] Hardware name: Socionext Developer Box (DT)
> [    5.741981] pstate: a0000005 (NzCv daif -PAN -UAO)
> [    5.741995] pc : clk_prepare+0x1c/0x60
> [    5.742007] lr : synquacer_spi_probe+0xe8/0x290 [spi_synquacer]
> [    5.742008] sp : ffff00000d5739e0
> [    5.742011] x29: ffff00000d5739e0 x28: ffff01911d855000
> [    5.742016] x27: ffff3dda0e962000 x26: 0000000000000000
> [    5.742021] x25: ffff01911d8542d0 x24: 0000000000000010
> [    5.742026] x23: ffffbed27ffed5c8 x22: ffffbed25b7cb400
> [    5.742031] x21: fffffffffffffffe x20: ffffbed25658b000
> [    5.742036] x19: fffffffffffffffe x18: ffffffffffffffff
> [    5.742041] x17: 0000ffff90f5ce58 x16: ffff3dda0e3cb818
> [    5.742046] x15: ffff3dda0ee59c08 x14: ffffffffffffffff
> [    5.742051] x13: 0000000000000028 x12: 0101010101010101
> [    5.742055] x11: 0000000000000038 x10: 0101010101010101
> [    5.742060] x9 : 0000000000000002 x8 : 7f7f7f7f7f7f7f7f
> [    5.742065] x7 : ff6c73712c647274 x6 : 0000000000000080
> [    5.742070] x5 : 0000000000000000 x4 : 8000000000000000
> [    5.742075] x3 : 0000000000000000 x2 : 0000000000000000
> [    5.742079] x1 : 0000000000000001 x0 : ffff01911d852778
> [    5.742086] Process systemd-udevd (pid: 389, stack limit =
> 0x00000000cdd89d3b)
> [    5.742088] Call trace:
> [    5.742093]  clk_prepare+0x1c/0x60
> [    5.742101]  synquacer_spi_probe+0xe8/0x290 [spi_synquacer]
> [    5.742109]  platform_drv_probe+0x60/0xc8
> [    5.742114]  driver_probe_device+0x2dc/0x480
> [    5.742119]  __driver_attach+0x124/0x128
> [    5.742124]  bus_for_each_dev+0x78/0xe0
> [    5.742128]  driver_attach+0x30/0x40
> [    5.742132]  bus_add_driver+0x1f8/0x2b0
> [    5.742136]  driver_register+0x68/0x100
> [    5.742141]  __platform_driver_register+0x54/0x60
> [    5.742148]  synquacer_spi_driver_init+0x1c/0x1000 [spi_synquacer]
> [    5.742154]  do_one_initcall+0x5c/0x168
> [    5.742161]  do_init_module+0x64/0x1e0
> [    5.742167]  load_module+0x1ed0/0x2198
> [    5.742172]  SyS_finit_module+0x128/0x140
> [    5.742176]  __sys_trace_return+0x0/0x4
> [    5.742183] Code: aa0003f3 aa1e03e0 d503201f b4000193 (f9400273)
> [    5.742188] ---[ end trace 831278301b1eda70 ]---
>
>
> It looks like the call
>
> clk_prepare_enable(sspi->clk[IPCLK]);
>
> is passing the ERR() value of devm_clk_get() rather than NULL. Adding
> 'if (!IS_ERR())' fixes it for me.
>
I had thought the clk_xyz() calls would immediately return if invalid
clock was provided, but I see they return only if the passed clock is
a NULL pointer, and not when its ERR_PTR. I think a better option
would be to make it NULL if devm_clk_get returns ERR_PTR.

Stephen, does it make sense to also catch the ERR_PTR in
clk_enable/prepare?   Like clk_disable, clk_unprepare already does.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
