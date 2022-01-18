#ifndef _ADV7511_CONTROL_H_
#define _ADV7511_CONTROL_H_

void adv7511_hal_init(struct _demo_t * pdemo);
void adv7511_hal_print_status();
int adv7511_hal_is_power_down();
int adv7511_hal_get_status( struct _demo_t * pdemo );
int adv7511_start( struct _demo_t * pdemo);
void adv7511_hal_print_chip_rev(demo_t * pdemo);

#endif//_ADV7511_CONTROL_H_
